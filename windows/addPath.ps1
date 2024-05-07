try {
  # Retrieve the current value of the PATH environment variable
  $CurrentValue = [Environment]::GetEnvironmentVariable("PATH", "Machine")

  # Check if the current directory is already in the PATH value
  if ($CurrentValue -notlike "*$([Environment]::CurrentDirectory);*") {

      # Construct the new PATH value by appending the current directory to the existing value
      $NewValue = "$CurrentValue;$([Environment]::CurrentDirectory);"

      # Set the new PATH value
      [Environment]::SetEnvironmentVariable("PATH", $NewValue, "Machine")

      # Display a confirmation message
      Write-Host "The current directory has been added to the system environment variables."

  } else {
      # If the current directory is already in the PATH value, display a message indicating this
      Write-Host "The current directory is already present in the system environment variables."
  }
} catch {
  # If an error occurs, display an error message with the details of the error
  Write-Host "An error occurred while adding the current directory to the system environment variables:`n$($_.Exception.Message)" -ForegroundColor Red
}
