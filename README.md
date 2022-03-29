# fifo-based-sram
I have tried creating a ring buffer/sram based on first in first out principle. The language I have used is VHDL. The SRAM is also synchronised based on handshake principle where read enable and write enable signals are synchronised according to sram clock, full is synchronised according to writer clock and empty according to reader clock.
The basic principle that I have used is that I have taken two pointers rd_ptr and wr_ptr. rd_ptr points to the memory location that will be read in the next cycle based on a read enable signal. wr_ptr points to the memory location on which the incoming data will be written in the next cycle based on a write enable signal. In addition, I have used two additional pointers to evaluate whether the sram is full or empty. The present values of signal like full, empty, err (it gets high when one tries to read an empty sram or write a full sram) get displayed in the next cycle and not in the present cycle. 
Various signals used: clk: the clock frequency at which the sram operates. 
rst: to reset the memory to zero and the signals to their initial values
err: it gets high when one tries to read an empty sram or write a full sram
empty: it gets high when the sram is empty
empty_nx: it gets high when sram will get empty after reading one more memory location
full: it gets high when the sram is full
full_nx: it gets high when the sram will become full after writing on ome more memory location.
The logic is presented in the document attached[SRAM - Google Docs.pdf](https://github.com/AKR1711/fifo-based-sram/files/8372136/SRAM.-.Google.Docs.pdf)

