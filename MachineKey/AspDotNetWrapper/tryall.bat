@echo off

:: Parameters:
:: %1 = encrypted value
:: %2 = purpose (type of value (viewstate, etc.) see below for all possible values)

if "%1" == "" goto usage
if "%2" == "" goto usage


for %%a in (sha1 md5 3des aes hmacsha256 hmacsha384 hmacsha512) do (
 for %%b in (des 3des aes) do (
  aspdotnetwrapper.exe -r machinekeys.txt -d -f decrypted.txt -c %1 -p %2 -a %%a -b %%b
 )
)
goto end

:: possible values for -p (purpose): https://github.com/NotSoSecure/Blacklist3r/blob/master/MachineKey/AspDotNetWrapper/AspDotNetWrapper/Customization/DefinePurpose.cs#L27
:: possible values for -a and -b (algos): https://docs.microsoft.com/en-us/previous-versions/dotnet/netframework-4.0/w8h3skw9(v=vs.100)?redirectedfrom=MSDN

:usage
echo Usage: %0 EncryptedValue ValueType
echo ValueType is one of: owin.cookie, aspxauth, viewstate, scriptresource, webresource

:end
