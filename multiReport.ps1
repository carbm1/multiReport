. .\settings.ps1
. .\functions.ps1

$espTablesMeta = Import-Csv .\espTables.csv

$espTables = New-Object System.Collections.ArrayList

$espTableCols = $espTablesMeta | Group-Object -Property tblName | ForEach-Object { 

    $espTables.Add(
        [pscustomobject]@{ 
            table = $PSItem.name
            columns = ($PSItem.Group | Select-Object -ExpandProperty colName) -join ','
        }
    )
}

$rptPages = @()
$rptQueries = @()
$rptVariables = @()
$espTables | ForEach-Object {

    #build the pages,queries and variables for all of them.
    $table = $PSItem

    #build the page first.
    $page = New-CognosPage -table $table.table
    
    $pageListColumns = @()
    ($table.columns).split(',') | ForEach-Object {
        $pageListColumns += New-CognosPageColumn -name $PSItem
    }

    $rptPages += $page -replace '{{listcolumn}}',($pageListColumns -join "`n")

    #build the query
    $query = New-CognosQuery -table $table.table

    $queryDataItems = @()
    ($table.columns).split(',') | ForEach-Object {
        $queryDataItems += New-CognosQueryDataItem -table $table.table -item $PSItem
    }

    $rptQueries += $query -replace '{{DATAITEMS}}',($queryDataItems -join "`n")

    $rptVariables += "<variableValue value=""$($table.table)""/>"

}

(New-CognosReport) -replace '{{PAGES}}',($rptPages -join "`n") -replace '{{QUERIES}}',($rptQueries -join "`n") -replace '{{VARIABLES}}',($rptVariables -join "`n") -replace '{{ESPDSN}}',$espdsn | clip