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
    "1.24.1": {
        "aarch64-apple-darwin": "sha384-u9R0SBbSc0CBOkGMnTKSlMKxPN+9nMGd3Q6HAzhaHqsQwvRDjtPmsF3wnn4obm78",
        "x86_64-apple-darwin": "sha384-na/vkDZPKuPWQV5jMqpj1iCE+S3rv2j161yvzN03egyMnTa5nNJja0rJHlHIvVlo",
        "x86_64-pc-windows-msvc": "sha384-L/SLyxIJhuEVGm4cq6ZiL3aaxfeNlIceJOdsR1KxIOy61AyKGjPVCz+/mMoXLopV",
        "x86_64-unknown-linux-gnu": "sha384-LKP0QvtNVCa1qAQp4j+8u00IjPDjklNouc/SthOJ025tdz5nWrnWZapVYFadXv2e",
    },
    "1.31.1": {
        "aarch64-apple-darwin": "sha384-Q59mRhjwGSLOSN25+AQfRq70ph2hxj1zeWixbHsOMQEskOe3w0QUk0Bc/tiCSN9b",
        "x86_64-apple-darwin": "sha384-Eg9hOHdSj3exVjZnTd4aMXpwaRT+Tc1bhsUiYToTylb6gEWJs3zQy2JFM4oHYCNS",
        "x86_64-pc-windows-msvc": "sha384-wuuY5z5m984ZzhiqnBpau3WWc7rY7jpT/Bvxe2d8e9ebvFUr+S6aVp41BxGG2W8E",
        "x86_64-unknown-linux-gnu": "sha384-/vLIKbP7saUEOPksBI6rmwBvJtbRboqNV33NFKaq9napAOZLMnMU3GlLLnBwTIyo",
    }
}

LATEST_VERSION = DENO_VERSIONS.keys()[-1]
