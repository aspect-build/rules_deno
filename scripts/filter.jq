map(
    {
        "key": .tag_name,
        "value": .assets
            | map(select(.name | contains("zip")))
            | map({
                # convert deno-aarch64-apple-darwin.zip -> aarch64-apple-darwin
                "key": .name | split(".")[0] | ltrimstr("deno-") | ascii_downcase,
                # We'll replace the url with the shasum of that referenced file in a later processing step
                "value": .browser_download_url | split("/")[-1]
            })
            | from_entries
    }
) | from_entries
