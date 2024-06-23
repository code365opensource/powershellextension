function Invoke-UniWebRequest {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true)]
        [hashtable]$params
    )

    $contenttype = "application/json;charset=utf-8"
    #check if the $params contains headers and the headers contains content-type,if so, read the content-type, remove it from headers
    if ($params.ContainsKey('headers') -and $params.headers.ContainsKey('Content-Type')) {
        $contenttype = $params.headers.'Content-Type'
        $params.headers.Remove('Content-Type')
    }
    $response = Invoke-WebRequest @params -ContentType $contenttype

    if (($PSVersionTable['PSVersion'].Major -ge 6) -or ($response.Headers['Content-Type'] -match 'charset=utf-8')) {
        return $response.Content
    }
    else {

        $dstEncoding = [System.Text.Encoding]::GetEncoding('iso-8859-1')
        $srcEncoding = [System.Text.Encoding]::UTF8
        $result = $srcEncoding.GetString([System.Text.Encoding]::Convert($srcEncoding, $dstEncoding, $srcEncoding.GetBytes($response.Content)))
        return $result
    }
}
