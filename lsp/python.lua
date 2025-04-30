return {
    cmd = { 'basedpyright-langserver', '--stdio' },
    root_markers = {
        'server.py',
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        '.git',
    },
    filetypes = { 'python' },
    settings = {
        basedpyright = {
            include = {"./"},
            exclude = {"**/__pycache__", "**/node_modules"},
            reportMissingTypeStubs = false,
            analysis = {
                pythonVersion = "3.9",
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
                reportMissingTypeStubs = false,
                autoImportCompletions = true,
                useLibraryCodeForTypes = true
            }
        }
    }
}
