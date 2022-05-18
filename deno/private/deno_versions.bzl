"""Mirror of release info

TODO: generate this file from GitHub API"""

DENO_VERSIONS = {
    "1.14.2": {
        "x86_64-apple-darwin": "sha384-ws4+rANvv0YxM1SgIBUXSG9jT8dKw83nls6R5qYkEKzPUB+viBIEozSsyq2e6i+f",
        "aarch64-apple-darwin": "sha384-HcvJbxoJtGSavkGu0e7CyD00cBlmDb0TBWJ4JSaNa70zuU3N7XlMOYm3bbQcAv2U",
        "x86_64-pc-windows-msvc": "sha384-35YN6TKpT0L9qyRBmq48NucvyXEtHnkeC+txf2YZmmJTmOzrAKREA74BA0EZvpar",
        "x86_64-unknown-linux-gnu": "sha384-QgGOwTaetxY0h5HWCKc/3ZtBs4N/fgaaORthn7UcEv++Idm9W+ntCCZRwvBdwHPD",
    },
    "1.21.3": {
        "x86_64-apple-darwin": "sha384-dlMhWsYlaYw8ebgaSsIwWid4OngzIT7oMEWIgP70gSH/g4vwD2NLkl0at/0hY4/b",
        "aarch64-apple-darwin": "sha384-uYvwRK0ng8nIfBIY/SlJlJOIlwnk96Bebprw9Jf7bxvnyfl0X/iolvZ38PiGQazk",
        "x86_64-pc-windows-msvc": "sha384-BljBxezjflY9i64CnkCPAhHUbTxdEVF7JVfSpa6e7MfjXQPoaFAVAu9qavr/8gU5",
        "x86_64-unknown-linux-gnu": "sha384-fqYpdOr10axKEG9b7KrMNwwlxdYnoqf+Mrcw/KoOzgNgRSB1sCUfRR3vcIvAcPlJ",
    },
}

LATEST_VERSION = DENO_VERSIONS.keys()[-1]
