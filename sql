#!/usr/bin/perl
use strict;
use warnings;

# Example SQL statements
my @sql_statements = (
    "SELECT * FROM table WHERE column1 = 'value1' AND column2 > 5",
    "SELECT id, name FROM users WHERE age >= 30 OR status = 'active'",
    "SELECT product_id FROM products WHERE price < 100 AND stock >= 50"
);

# Regex to capture variables after WHERE clause
my $where_clause_regex = qr/
    \bWHERE\b      # Match the WHERE keyword
    (.*?)          # Capture everything after WHERE up to the end of the line or statement
    (?:\bORDER\b|\bGROUP\b|\bLIMIT\b|$)  # Stop capturing at ORDER, GROUP, LIMIT, or end of statement
/x;

# Regex to capture variables in the condition expressions
my $condition_regex = qr/
    \b(\w+)\b      # Match word characters as variable names
    \s*            # Optional whitespace
    (?:=|>|<|>=|<=|!=|<>|\s+LIKE\s+|\s+IN\s+)  # Match SQL operators
/x;

# Loop through each SQL statement
foreach my $sql (@sql_statements) {
    # Extract the part after WHERE clause
    if ($sql =~ $where_clause_regex) {
        my $where_part = $1;

        # Find all variables in the WHERE part
        while ($where_part =~ /$condition_regex/g) {
            print "Variable: $1\n";
        }
    }
}