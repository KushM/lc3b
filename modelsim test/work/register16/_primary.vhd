library verilog;
use verilog.vl_types.all;
entity register16 is
    port(
        q               : out    vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        d               : in     vl_logic_vector(15 downto 0);
        reset           : in     vl_logic;
        load            : in     vl_logic
    );
end register16;
