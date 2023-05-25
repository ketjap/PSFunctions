function Get-MaxLengthFromPSObject {
    <#
    .SYNOPSIS
        Get Max lenght from a psobject.

    .DESCRIPTION
        This will check the length of all cells in a table and output the maximum length. Like the content of a csv file.

    .PARAMETER InputObject
        PSObject containing the table structure.

    .EXAMPLE
        $CSVFile=Import-Csv -Path csvfile.csv
        Get-MaxLengthFromPSObject -InputObject $CSVFile

        This will check all content of the csv file and output the maximum length per column.
    
    .LINK
        https://github.com/ketjap/PSFunctions

    .NOTES
        Author: Sander Siemonsma
    #>

    param (
        [Parameter(Mandatory = $true)]
        [psobject]
        $InputObject
    )

    $NotePropertyNames = ($InputObject | Get-Member -MemberType Noteproperty).Name
    $outputline = "" | Select-Object -Property $NotePropertyNames

    $outputLength = foreach ($InputObjectline in $InputObject) {
        $outputline = "" | Select-Object -Property ($InputObject | Get-Member -MemberType Noteproperty).Name
        foreach ($NotePropertyName in $NotePropertyNames) {
            $outputline.$NotePropertyName = $InputObjectline.$NotePropertyName.Length
        }
        $outputline
    }

    $outputMax = "" | Select-Object -Property $NotePropertyNames
    foreach ($NotePropertyName in $NotePropertyNames) {
        $outputMax.$NotePropertyName = ($outputLength.$NotePropertyName | Measure-Object -Maximum).Maximum
    }
    $outputMax
}
