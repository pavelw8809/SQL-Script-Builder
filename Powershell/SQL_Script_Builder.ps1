# GET INPUT DATA
$inputFile = "F:\_PROG\_POWERSHELL\GeoData\output\voivList_0.1.csv"

$input = Import-Csv -Path $inputFile

$MySqlDataTypes = @(
	@("cstring","CHAR", 255),
	@("string","VARCHAR", 65535),
	@("binary","BINARY",$null),
	@("bstring","VARBINARY",$null),
	@("int","TINYINT",127),
	@("int","SMALLINT",65535),
	@("int","")
)

# Int32
# String


# CREATE PROPERTIES IN SECOND LINE
### INT(30)_MAIN,VARCHAR(20),VACHAR(15),VARCHAR(30)

#$getColumnList = ($input | Get-Member -MemberType NoteProperty).Name
$getColumnList = (Get-Content -Path $inputFile | select -First 1) -split ","
$getColumnList

# Check if properties/data types are defined in second line and validate them


# Get data type

Function EstimateDateLengthForString {
	param(
		[int]$Number
	)

	$NumberLength = $Number.ToString().Length
	$DivisionCoefficientStr = "1" + "0"*($NumberLength-1)
	$DivisionCoefficient = 0
	[int]::TryParse($DivisionCoefficientStr, [ref]$DivisionCoefficient)

	$EstimatedLength = [Math]::Round($Number/$DivisionCoefficient)*$DivisionCoefficient+$DivisionCoefficient
	return $EstimatedLength
}

Function GetEstimatedLengthForInt {
	param(
		[int]$Number
	)

	$DataType = $null
	
	switch($Number) {
		{$Number -lt 128} {
			$DataType = "TINYINT"
			;break
		}
		{$Number -lt 65535} {
			$DataType = "SMALLINT"
			;break
		}
		{$Number -lt 16777215} {
			$DataType = "MEDIUMINT"
			;break
		}
		{$Number -lt 4294967295} {
			$DataType = "INT"
			;break
		}
		{$Number -gt 4294967295} {
			$DataType = "BIGINT"
			;break
		}
		default: {
			$DataType = "INT"
			;break
		}
	}

	return $DataType
}

Function GetEstimatedLengthForDouble {
	param(
		$Number
	)

	$datatype = "DECIMAL"

	$GetNumberParts = $Number.ToString() -split "."
	$FullNumLength = [Math]::Round($Number).ToString().Length + 1
	$TailLenth = $GetNumberParts[1].Length

	$DecimalLength = $FullNum + $TailLenth
	$datatype = "$DecimalLength,$Tail"

	return $datatype
}

Function Get-DataType {
	param($data)

	$getMaxLength = ($data | Sort-Object length -desc | Select-Object length -First 1).Length

	$outputN = $null
	
	$output = [PSCustomObject]@{
		Type = $null
		Length = $null
	}

	switch ($data) {
		{($data.GetType()).Name -eq "Int32"} {
			$output.Type = GetEstimatedLengthForInt($data)
			;break
		}
		{($data.GetType()).Name -eq "Double"} {
			$output.Type = "DECIMAL"
			$output.Length = GetEstimatedLengthForDouble($Number)
			;break
		}
		{($data.GetType()).Name -eq "String" -And [string]$data -as [DateTime]} {
			$output.Type = "DATETIME"
			;break
		}
		{($data.GetType()).Name -eq "String"} {
			$output.Type = "VARCHAR"
			$output.Length = GetEstimatedLengthForStr($data)
			;break
		}
	}
}

switch($val)

if ([string]$val -as [DateTime]) {

}

if (($val.GetType()).Name -eq "String") {

}

if (($val.GetType()).Name -eq "Int32") {

}

Get-TypeData

# Get Prop length
($inputK.Voiv_Name | Sort-Object length -desc | Select-Object length -First 1).Length
