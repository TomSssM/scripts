# Sync Checksums Databases

Given two Checksums Databases `integrity-1.sha1` and `integrity-2.sha1` see which files to add to and delete from the first Checksums Database `integrity-1.sha1` so that it becomes the same as the second Checksums Database `integrity-2.sha1`:

```shell
node findfile.js ./integrity-1.sha1 ./integrity-2.sha1
```
