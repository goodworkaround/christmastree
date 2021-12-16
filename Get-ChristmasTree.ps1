[CmdletBinding()]

Param (
    [ValidateRange(3,60)]
    [int] $Height = 40,

    [char] $FillCharacter = ' ',

    [string[]] $DecorationColors = @("Yellow","Red","Blue"),

    [ValidateRange(0,60)]
    [int] $LeftPadding = 1
)

Process {
    Write-Host "*".PadLeft($Height + 1 + $LeftPadding) -ForegroundColor Yellow
    $Height..1 | ForEach-Object {
        $line = $_ 
        Write-Host "/".PadLeft($_ + $LeftPadding) -ForegroundColor Green -NoNewline

        $lastspace = $false
        ($Height - $_)..-(($Height - $_)) | ForEach-Object {
            
            $r = Get-Random -Minimum 1 -Maximum 1000

            $Color = $DecorationColors | Get-Random -Count 1
            if($r -lt 30 -and $lastspace) {
                Write-Host "*" -NoNewline -ForegroundColor $Color
                $lastspace = $false
            } elseif($r -lt 60 -and $lastspace) {
                Write-Host "o" -NoNewline -ForegroundColor $Color
                $lastspace = $false
            } elseif($r -lt 90 -and $lastspace) {
                Write-Host "+" -NoNewline -ForegroundColor $Color
                $lastspace = $false
            } else {
                #Write-Host " " -NoNewline
                Write-Host $FillCharacter -NoNewline -ForegroundColor Green
                $lastspace = $true 
            }
        }

        Write-Host "\" -ForegroundColor Green
    }
    Write-Host "".PadLeft($LeftPadding) -NoNewline
    Write-Host "-".PadLeft((($Height * 2) + 1), "-") -ForegroundColor Green

    $footwidth = ($Height * 2) / 10
    $footstart = ((($Height * 2) - $footwidth) / 2) + 1
    $footheight = $Height / 10
    $footheight..1 | foreach {
        Write-Host "|".PadLeft($footstart + $LeftPadding) -ForegroundColor DarkRed -NoNewline
        Write-Host "|".PadLeft($footwidth) -ForegroundColor DarkRed 
    }
}