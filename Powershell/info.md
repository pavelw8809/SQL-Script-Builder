# DATA TYPES

# CHAR(n) -> 0-255 - tylko 1 bajt (a więc znaków specjalnych nie obsługuje) i ma sztywną długość - w nieużywanej są spacje
# CHAR gdy mamy ten sam/podobny rozmiar wartości T/N, itp. i wtedy jest szybszy od VARCHAR
# VARCHAR(n) -> 0-65535 - dlugość równa ale max równa n
# BINARY(n)
# VARBINARY(n)

# TINYINT -> 0-127
# SMALLINT -> 0-65535
# MEDIUMINT -> 0-16777215
# INT -> 4294967295
# BIGINT -> 4294967295
# SERIAL = BIGINT AND UNIQUE AND AUTO_INCREMENT

# DECIMAL(W,D) -> MAX W 65 cyfr, MAX D 30 cyfr (domyślnie 10 cyfr)
# FLOAT(W,D) => 0-23 cyfr
# DOUBLE(W,D) => 24-53 cyfr
# INT - whole nums

# DECIMAL and DATA are best for math.

# BIT - SZEREG WARTOŚCI 0 i 1

# TINYTEXT -> VARCHAR(255)
# TEXT -> 2^16 znaków
# MEDIUMTEXT -> 2^24 znaków
# LONGTEXT -> 2^32 znaków

# TINYBLOB -> BINARNA FORMA - 1 bajt
# BLOB -> 2 bajty
# MEDIUMBLOB -> 3 bajty
# LONGBLOB -> 4 bajty

# ENUM - lista wartości - tylko jedną wartość można wybrać
# SET - lista wartości - kilka wartości może być wybrane

# DATE (YYYY/MM/dd)
# TIME (HH:mm:ss)
# DATETIME (YYYY/MM/dd HH:mm:ss)
# TIMESTAMP (UNIX)


# OPTIONS:
# make decimal, double and float with precise