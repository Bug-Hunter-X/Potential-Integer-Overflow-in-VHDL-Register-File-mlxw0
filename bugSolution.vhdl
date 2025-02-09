```vhdl
ENTITY register_file IS
  GENERIC (data_width : INTEGER := 32; addr_width : INTEGER := 5);
  PORT (
    clk : IN STD_LOGIC;
    wr_en : IN STD_LOGIC;
    wr_addr : IN STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);
    wr_data : IN STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
    rd_addr1 : IN STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);
    rd_addr2 : IN STD_LOGIC_VECTOR(addr_width - 1 DOWNTO 0);
    rd_data1 : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
    rd_data2 : OUT STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0)
  );
END ENTITY;

ARCHITECTURE behavioral OF register_file IS
  TYPE reg_array IS ARRAY (0 TO (2**addr_width - 1)) OF STD_LOGIC_VECTOR(data_width - 1 DOWNTO 0);
  SIGNAL registers : reg_array := (OTHERS => (OTHERS => '0'));
  SIGNAL wr_addr_int : INTEGER RANGE 0 TO (2**addr_width - 1);
  SIGNAL rd_addr1_int : INTEGER RANGE 0 TO (2**addr_width - 1);
  SIGNAL rd_addr2_int : INTEGER RANGE 0 TO (2**addr_width - 1);
BEGIN
  -- Integer conversion with range check
  wr_addr_int <= to_integer(unsigned(wr_addr));
  rd_addr1_int <= to_integer(unsigned(rd_addr1));
  rd_addr2_int <= to_integer(unsigned(rd_addr2));

  register_process : PROCESS (clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF wr_en = '1' THEN
        registers(wr_addr_int) <= wr_data;
      END IF;
    END IF;
  END PROCESS;

  rd_data1 <= registers(rd_addr1_int);
  rd_data2 <= registers(rd_addr2_int);
END ARCHITECTURE;
```