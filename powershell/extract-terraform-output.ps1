

# Extract Terraform Output into Environment Variables

Write-Host "[HELLO] Extract Terraform Output into Environment Variables" -ForegroundColor Blue
$timestampNow = Get-Date -Format "yyyyddmm-HHmm"

$envHeader = "AZ_TF"

# Check: Are we in a terraform folder?
$searchPath = $PSScriptRoot + "\terraform.tfstate"
If ([System.IO.File]::Exists($searchPath)) {

    # We are. Process the Terraform Outputs
    Write-Host "[OK] Terraform .state found" -ForegroundColor DarkGreen

    # Run Terraform, save output
    $outputFile = "./terraform-output-$timestampNow.json"
    terraform output -json > $outputFile

    # Import the file
    $outputs = @(Get-Content $outputFile -raw | ConvertFrom-Json)

    $outputs | ForEach-Object {
            $_.PSObject.Properties | ForEach-Object {

                    # Extract the key name
                    $keyName = $_.name
                    $keyCaps = $keyName.ToUpper()

                    # Create environment variable name
                    $envVariableName = "${envHeader}_${keyCaps}"
                    $envValue = $outputs.$keyName.value
                    $isSensitive = $outputs.$keyName.sensitive

                    # Set the variable
                    Set-Item -Path ENV:$envVariableName -Value $envValue

                    Write-Host -NoNewline "[ADDED] ${envVariableName} " -ForegroundColor DarkYellow
                    If ($isSensitive -eq "true") {

                        Write-Host "WARNING: SENSITIVE" -BackgroundColor DarkRed -ForegroundColor White

                    } else {
                        Write-Host
                    }

                }
            } 

    # Remove the temporary Json file
    Remove-Item -Path $outputFile

} Else {

    Write-Host "[ERROR] No Terraform .state file detected" -ForegroundColor Red

}

Write-Host "[GOODBYE]" -ForegroundColor Blue


