library verilog;
use verilog.vl_types.all;
entity pcIncrement is
    port(
        pcOut           : in     vl_logic_vector(15 downto 0);
        increasedPC     : out    vl_logic_vector(15 downto 0)
    );
end pcIncrement;
