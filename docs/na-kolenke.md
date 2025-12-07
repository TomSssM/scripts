# Find Files for the Checksums Database

Check if the files from the Checksums Database `integrity.sha1` are present in the files from the File System `files.txt`:

```shell
node na-kolenke.js --checksum ./integrity.sha1 --files ./files.txt
```

---

The files from the File System `files.txt` not present in the Checksums Database `integrity.sha1` are logged to the console

If some files from the Checksums Database `integrity.sha1` are not present in the File System `files.txt` an error is thrown with a list of the files to be added to the File System

## Specification

### Arguments

| Name | Description |
|---|---|
| `--checksum` | Path to Checksums Database |
| `--files` | Path to File System |
