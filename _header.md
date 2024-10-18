# Emergency Access Accounts in Entra ID

Implement [Emergency access accounts](https://docs.microsoft.com/en-us/azure/active-directory/roles/security-emergency-access), assign it the Global Administrator-role and Owner-role on the (root) management group.

## v1.0 updates

The module was originally created in 2022. Since then, a lof of things have changed, and from October 15, 2024, Microsoft requires all accounts to have MFA enabled. Due to this, v1.0 of this module introduce breaking changes:

- Log analytics workspace and diagnostic settings for EntraID SignInLogs are moved out of the module
- Conditional access policy scoped to emergency access users will be created together and require the use of FIDO2 keys by default. This means the module now require Entra ID P2 licenses