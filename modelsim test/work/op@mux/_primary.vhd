library verilog;
use verilog.vl_types.all;
entity opMux is
    port(
        opmux           : in     vl_logic_vector(1 downto 0);
        RB              : in     vl_logic_vector(15 downto 0);
        irOut           : in     vl_logic_vector(15 downto 0);
        opmuxOut        : out    vl_logic_vector(15 downto 0);
        lshift          : in     vl_logic
    );
end opMux;
