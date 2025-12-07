# Check if one File System contains another File System

Check if the files _from_ the source File System `files-1.txt` are present _in_ the input File System `files-2.txt`:

```shell
node cmpFilesDb.js --from ./files-1.txt --in ./files-2.txt
```

Save the output of the script into a log file `report.txt`:

```shell
node cmpFilesDb.js --from ./files-1.txt --in ./files-2.txt --out report.txt
```

---

The script logs a list of the files from the source File System `files-1.txt` that are missing in the input File System `files-2.txt`

If the source File System `files-1.txt` has fewer files in it than the input File System `files-2.txt` (in other words, if the input File System `files-2.txt` has some files that are missing in the source File System `files-1.txt`) then the script exits and throws an error to the console with a list of the files that are missing in the source File System `files-1.txt` (because the script can provide a full diff between the two File Systems only if we assume that the source File System `files-1.txt` is a superset of the input File System `files-2.txt`). You can disable this behavior by using the `--lax` flag. With the `--lax` flag enabled the script will log a warning to the console instead of exiting with an error

## Specification

### Arguments

| Name | Description |
|---|---|
| `--from` | Path to source File System |
| `--in` | Path to input File System |
| `--out` | Path to log file to save the output of the script |
| `--lax` | Disable throwing an error if the source File System is not a superset of the input File System |
