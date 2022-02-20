# multiReport
This project has absolutely zero purpose but I didn't want to lose the work.  This might be useful if we wanted to limit it to certain tables but outside of that its useless.

The problem is that Cognos runs all the SQL queries regardless of what variable to pass for page rendering.

1. Run multiReport.ps1 and a report is placed in your clipboard.
2. Create a new blank Cognos Report, click the three vertical dot menu in top right.
3. Open Report from Clipboard. Paste Clipboard

## Future?
To be useful we would need to modify the SQL and pass change datetime for columns that have it.