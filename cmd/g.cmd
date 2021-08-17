@ECHO OFF
pushd "%~dp0"

SET g_command_alias=%1
IF ""=="%g_command_alias%" (
    GOTO NOALIAS
)

SET g_command_mapping_path="%UserProfile%\.grc"
IF NOT EXIST %g_command_mapping_path% (
    GOTO NOMAPPINGFILE
)


SET g_command_tempfile_prefix=.temp_file_target_folder_bat
REM find the target folder and save the output to a temp file
SET g_command_tempfile=%g_command_tempfile_prefix%%RANDOM%

cat %g_command_mapping_path%|grep -E "^%g_command_alias%\s"|awk '{$1=""; print $0}'>%g_command_tempfile%

REM read the file to a variable
SET /p g_command_target=<%g_command_tempfile%

REM clean up
RM %g_command_tempfile%

REM cd
IF ""=="%g_command_target%" (
    GOTO NOTARGET
)

CALL CD /d "%g_command_target%"

GOTO END

:NOALIAS
ECHO Alias not provided.
GOTO END

:NOTARGET
ECHO No mapping found in %g_command_mapping_path%
GOTO END

:NOMAPPINGFILE
ECHO No mapping file found. Create %g_command_mapping_path% to start.
GOTO END

:END
REM clean up temp variables
SET g_command_alias=
SET g_command_tempfile_prefix=
SET g_command_tempfile=
SET g_command_target=
SET g_command_mapping_path=