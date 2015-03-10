library verilog;
use verilog.vl_types.all;
entity srMux is
    port(
        srmux           : in     vl_logic;
        irOut           : in     vl_logic_vector(15 downto 0);
        srmuxOut        : out    vl_logic_vector(2 downto 0)
    );
end srMux;
