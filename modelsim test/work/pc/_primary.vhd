library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        pcin            : in     vl_logic_vector(15 downto 0);
        pcout           : out    vl_logic_vector(15 downto 0);
        pcE             : in     vl_logic
    );
end pc;
