Function UpdateVersionInFile
{
    Param ([string]$path, [string]$prefix, [string]$suffix, [int]$verNum)

    if ($env:BUILD_NUMBER)
    {
        $lines = Get-Content $path -Encoding UTF8

        $new_lines =  $lines | %{
            if ($_.StartsWith($prefix))
            {
                $num = $_.Substring($prefix.Length, $_.Length - $prefix.Length - $suffix.Length)
                $num_p = $num.Split('.')
                $new_num = [System.String]::Join('.', $num_p[0 .. ($verNum-2)] + $env:BUILD_NUMBER)
                return $prefix + $new_num + $suffix
            }
            else
            {
                return $_
            }        
        }

        Set-Content -Path $path -Value $new_lines -Encoding UTF8
    }
}

UpdateVersionInFile ((Split-Path -Parent $PSCommandPath) + '\..\wastorage.v120.nuspec') '    <version>' '</version>' 4

UpdateVersionInFile ((Split-Path -Parent $PSCommandPath) + '\..\wastorage.v140.nuspec') '    <version>' '</version>' 4

UpdateVersionInFile ((Split-Path -Parent $PSCommandPath) + '\..\wastorage.nuspec') '    <version>' '</version>' 4

UpdateVersionInFile ((Split-Path -Parent $PSCommandPath) + '\..\wastorage.nuspec') '      <dependency id="wastorage.v120" version="' '" />' 4

UpdateVersionInFile ((Split-Path -Parent $PSCommandPath) + '\..\wastorage.nuspec') '      <dependency id="wastorage.v140" version="' '" />' 4