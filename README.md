# Potential Integer Overflow in VHDL Register File

This repository demonstrates a potential integer overflow bug in a VHDL register file implementation. The bug arises from the use of `to_integer` to convert an unsigned vector to an integer, which can overflow if the vector represents a number larger than the maximum representable integer.  This can lead to unexpected behavior and potentially crashes.

## Bug Description

The provided VHDL code implements a register file. The code converts the address inputs (`wr_addr`, `rd_addr1`, `rd_addr2`) using `to_integer` to index the register array.  If the `addr_width` generic is large enough, this conversion may result in an integer overflow, leading to unexpected behavior, likely writing to or reading from an unintended register location or causing a simulation error.