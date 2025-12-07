# Check if one Checksums Database contains another Checksums Database

Check if the checksums _from_ the source Checksums Database `integrity-1.sha1` are present _in_ the input Checksums Database `integrity-2.sha1`:

```shell
node isPresent.js --from ./integrity-1.sha1 --in ./integrity-2.sha1
```

Save the output of the script into a log file `report.txt`:

```shell
node isPresent.js --from ./integrity-1.sha1 --in ./integrity-2.sha1 --out report.txt
```

---

The script logs a list of the files from the source Checksums Database `integrity-1.sha1` that are missing in the input Checksums Database `integrity-2.sha1`

If some files from the source Checksums Database `integrity-1.sha1` have different paths in the input Checksums Database `integrity-2.sha1` then the script also logs a list of these files to the console (with file paths from both Checksums Databases)

If the source Checksums Database `integrity-1.sha1` has fewer files in it than the input Checksums Database `integrity-2.sha1` (in other words, if the input Checksums Database `integrity-2.sha1` has some files that are missing in the source Checksums Database `integrity-1.sha1`) then the script also logs a warning to the console (because the script can provide a full diff between the two Checksums Databases only if we assume that the source Checksums Database `integrity-1.sha1` is a superset of the input Checksums Database `integrity-2.sha1`)

## Specification

### Arguments

| Name | Description |
|---|---|
| `--from` | Path to source Checksums Database |
| `--in` | Path to input Checksums Database |
| `--out` | Path to log file to save the output of the script |
