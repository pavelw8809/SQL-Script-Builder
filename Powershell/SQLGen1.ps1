class DataTypeObj {
    [string]$Name
    [string]$MySql
    [string]$PostgreSql
    $Max
    [string]$Format
}

$dataTypes = @(
    [DataTypeObj]@{Name = "int1";    MySql = "tinyint";   PostgreSQL = "smallint";         Max = 127;                 Format = "^\d{1,3}$"},
    [DataTypeObj]@{Name = "int16";   MySql = "smallint";  PostgreSQL = "smaillint";        Max = 32767;               Format = "^\d{1,5}$"},
    [DataTypeObj]@{Name = "int24";   MySql = "mediumint"; PostgreSQL = "integer";          Max = 8388607;             Format = "^\d{1,7}$"},
    [DataTypeObj]@{name = "int32";   MySql = "int";       PostgreSQL = "int";              Max = 2147483647;          Format = "^\d{1,10}$"},
    [DataTypeObj]@{name = "int64";   MySql = "int";       PostgreSQL = "int";              Max = 9223372036854775807; Format = "^\d{1,19}$"},
    [DataTypeObj]@{name = "decimal"; MySql = "decimal";   PostgreSQL = "decimal";          Max = '131072/16383';      Format = "^\d{1,131072}((\.|\,)\d{1,16383})?$"},
    [DataTypeObj]@{name = "numeric"; MySql = "numeric";   PostgreSQL = "numeric";          Max = '131072/16383';      Format = "^\d{1,131072}((\.|\,)\d{1,16383})?$"},
    [DataTypeObj]@{name = "float";   MySql = "float";     PostgreSQL = "real";             Max = 's9';                Format = 's9'}
    [DataTypeObj]@{name = 'double';  MySql = "double";    PostgreSQL = "double precision"; Max = "s16";               Format = "s16"}
)

Function Check-DecimalData {
    param()
}

Function Check-FractionData {
    param($Data, [int]$Max)

    $output = $false

    $intCount = ([regex]::Matches($Data, "[1-9]")).Count
    $zeroCount = ([regex]::Matches($Data, "0")).Count
    $sepCount = ([regex]::Matches($Data, "(\.|,)")).Count
    $dataLen = $Data.Length

    if ($intCount -le $Max -and $sepCount -eq 1 -and $dataLen -eq ($intCount+$sepCount+$zeroCount)) {
        $output = $true
    }

    return $output
}

Function AdditionalDataCheck {
    param(
        $Data,
        [string]$Rule
    )

    $output = $false

    switch ($Rule) {
        "s9" {
            $output = Check-FractionData $Data 9
            break;
        }
        "s16" {
            $output = Check-FractionData $Data 16
            break;
        }
        {$Rule.contains("/")} {
            $maxVals = $Rule.Split("/")
            $intCount = ([regex]::Matches($Data, "\d")).Count
            $IntFraction = ($Data.Split(".")).Split(",")
            $frcCount = $IntFraction[1].Length
            $sepCount = ([regex]::Matches($Data, "(\.|,)")).Count

            if ($intCount -lt $maxVals[0] -And $frcCount -lt $maxVals[1] -And $sepCount -eq 1 -And $Data.Length -eq ($intCount+$sepCount)) {
                $output = $true
            }
            break;
        }
    }

    return $output
}

AdditionalDataCheck "344.894334443" '131072/16383'