$json = Get-Content -Path .\tokens.json

function Tokenize-Text {
    param (
        $tokens,
        $text
    )
    $object = $json | ConvertFrom-Json 
    $tokens = $object | Get-Member -MemberType Properties | Select-Object -ExpandProperty Name
    ForEach($token in $tokens) 
    {
        #Write-Host $token
        #Write-Host $object."$token"
        $text = $text -Replace $token, $object."$token"
    }
    return $text
}

$test = Get-Content -Path .\test.txt
Write-Host $test
$tokenized = Tokenize-Text -tokens $json -text $test
Write-Host $tokenized
Set-Content -Path .\new.txt -Value $tokenized