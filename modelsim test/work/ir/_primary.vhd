library verilog;
use verilog.vl_types.all;
entity ir is
    port(
        din             : in     vl_logic_vector(15 downto 0);
        irOut           : out    vl_logic_vector(15 downto 0);
        irE             : in     vl_logic
    );
end ir;
