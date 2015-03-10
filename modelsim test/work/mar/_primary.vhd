library verilog;
use verilog.vl_types.all;
entity mar is
    port(
        din             : in     vl_logic_vector(15 downto 0);
        dout            : out    vl_logic_vector(15 downto 0);
        mare            : in     vl_logic
    );
end mar;
