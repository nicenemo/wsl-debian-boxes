#!/usr/bin/env pwsh
wsl --terminate $args[0]
wsl --unregister $args[0]
rm -r -fo c:\wsl\$args[0]
