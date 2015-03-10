library verilog;
use verilog.vl_types.all;
entity drMux is
    port(
        drmux           : in     vl_logic;
        irOut           : in     vl_logic_vector(15 downto 0);
        drmuxOut        : out    vl_logic_vector(2 downto 0)
    );
end drMux;
