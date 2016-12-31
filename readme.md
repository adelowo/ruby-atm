
> One of the many stupid/cool stuffs i will write in Ruby for the next n years

A Ruby program that simulates an (ATM)Automated Teller Machine session.

There are accounts. Accounts have a unique debit card - the cards are uniquely identified by their last 4 digits. Accounts may (not) have cash in them. Some accounts have a minimum balance policy - you cannot withraw all your cash.

The file `db.txt` contains some sample data. Each line is made up of some data delimited by `;` which in turn represents a `Customer` object.

Here is a sample line - `1011; 0000-1234-5678-1011; Lanre Adelowo, ?232{}! ; 50_000; 0`. After splitting this by `;`, we get an `[]` with the info below -

[0] -> The unique last four digit for the user's debit card.
[1] -> The 16 digits for the user's debit card.
[2] -> The user's full name.
[3] -> The user's password.
[4] -> The total amount of cash left in the user's bank account.
[5] -> The minimum amount of cash that must be left in the user's bank account. Can (s)he withdraw all ?.

