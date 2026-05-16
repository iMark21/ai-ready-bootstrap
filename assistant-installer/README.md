# assistant-installer

One file: [`PROMPT.md`](PROMPT.md) — a self-contained, tool-agnostic workflow
that an AI with local repo access follows to **install sdd-harness, audit the
repository, and fill the judgment-layer files** in a single instruction.

Use it by pasting this into your AI, from inside your target repo:

> Fetch `https://raw.githubusercontent.com/iMark21/sdd-harness/main/assistant-installer/PROMPT.md`
> and follow the complete workflow it defines for this repository.

If your AI cannot fetch URLs, download the file and tell it to read the local
copy instead.

This is the codified form of the cold-start that proved the framework on a
real legacy repo — see the "Proven in a real adoption" section of the
[root README](../README.md).
