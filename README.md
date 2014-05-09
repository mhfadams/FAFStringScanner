FAFStringScanner
================

A custom string scanner better suited to my parsing needs than NSScanner.

It supports sequential scanning by character, token, and literal string match.
It also handles reading balanced spans of text (that is, text enclosed in braces, brackets, quotes, and parenthesis).

API is fairly stable, but more tests and documentation are needed.

It operates on a 'cursor' mode, rather than 'insertion point', so the scan location always points to a character, rather than between characters.

(This is also my first GitHub repository, so I'm practicing)

Development Note: This class must remain compatible with OS-X 10.4.


