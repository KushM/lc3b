library verilog;
use verilog.vl_types.all;
entity mdrMux is
    port(
        memOut          : in     vl_logic_vector(15 downto 0);
        aluOut          : in     vl_logic_vector(15 downto 0);
        mdrmux          : in     vl_logic;
        mdrmuxOut       : out    vl_logic_vector(15 downto 0)
    );
end mdrMux;
