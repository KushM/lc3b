library verilog;
use verilog.vl_types.all;
entity registerFile is
    port(
        \bus\           : in     vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        WE              : in     vl_logic;
        DR              : in     vl_logic_vector(2 downto 0);
        SR1             : in     vl_logic_vector(2 downto 0);
        SR2             : in     vl_logic_vector(2 downto 0);
        RA              : out    vl_logic_vector(15 downto 0);
        RB              : out    vl_logic_vector(15 downto 0)
    );
end registerFile;
