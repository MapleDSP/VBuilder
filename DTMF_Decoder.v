//---------Module Definition--------

module DTMF_Decoder (
	input	wire			clk,
	output	wire			LED_1,
	output	wire			LED_2,
	input	wire	[15:0]	Link_Rx_Audio,
	output	wire	[15:0]	Link_Tx_Audio,
	input	wire	[15:0]	Main_Rx_Audio,
	output	wire	[15:0]	Main_Tx_Audio,
	output	wire	[7:0]	rd_data,
	input	wire			rdena,
	input	wire	[7:0]	reg_addr,
	input	wire			reset,
	input	wire	[7:0]	wr_data,
	input	wire			wrena
);

//---------Local Wires--------

wire	[7:0]			LocalWire_Net_10;
wire	[3:0]			LocalWire_Net_7;


//---------Instantiation of DTMFDecoder---------

DTMFDecoder
	DTMFDecoder_inst
		(
			.clk                 		(clk),
			.reset               		(reset),
			.Audio_in            		(Main_Rx_Audio),
			.Detect_out          		(LED_2),
			.Detect_digit        		(LocalWire_Net_7),
			.rdena               		(rdena),
			.wrena               		(wrena),
			.reg_addr            		(reg_addr),
			.rd_data             		(LocalWire_Net_10),
			.wr_data             		(wr_data)
		);


//---------Instantiation of MicroSequencer---------

MicroSequencer
	MicroSequencer_inst
		(
			.clk                 		(clk),
			.reset               		(reset),
			.Main_Rx_Audio       		(Main_Rx_Audio),
			.Main_Tx_Audio       		(Main_Tx_Audio),
			.Link_Rx_Audio       		(Link_Rx_Audio),
			.Link_Tx_Audio       		(Link_Tx_Audio),
			.COR_Heartbeat_LED   		(LED_1),
			.DTMF_Detect         		(LED_2),
			.DTMF_Digit          		(LocalWire_Net_7),
			.rdena               		(rdena),
			.wrena               		(wrena),
			.reg_addr            		(reg_addr),
			.wr_data             		(wr_data),
			.rd_data_in          		(LocalWire_Net_10),
			.rd_data             		(rd_data)
		);



endmodule

