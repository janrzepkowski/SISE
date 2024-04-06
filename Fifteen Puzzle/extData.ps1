# Extract data regarding performance of various strategies used to search the
# state space in order to solve the 15-puzzle. Data are extracted from
# statistics files generated by a solver program and stored in the current
# directory, aggregated in a tabular form, and the result is written to the
# standard output.
#
# The names of the statistics files should obey the following format:
#  size_depth_id_strategy_param_stats.txt
# for example:
#  4x4_01_00001_bfs_rdul_stats.txt

$StatsFilenameRegex = '^[a-zA-Z0-9]+_[0-9]+_[0-9]+_[a-zA-Z]+_[a-zA-Z]+_stats.txt$'

$SolDirectory = '.\solutions'
$StatsDirectory = '.\stats'

$StatsOutput = 'Data.csv'

Get-ChildItem -Path $StatsDirectory -File | Where-Object { $_.Name -match $StatsFilenameRegex } | ForEach-Object {
    ECHO $_.Name
    $InputFileName = $StatsDirectory + '\' + $_.Name
    $SplitFilename = $_.BaseName.Split("_")
    $Line = "{0} {1} {2} {3} " -f [int]$SplitFilename[1], [int]$SplitFilename[2], $SplitFilename[3], $SplitFilename[4]
    $Line += Get-Content $InputFileName
#     Write-Output $Line
    $Line >> $StatsOutput
}