package kr.happyjob.study.business.model;

public class productModel { 
	
	private String prd_code;
	
	private String prd_name;	
	
	private String pb_code;	
	
	private String pb_name;	

	private String ps_code;
	
	private String ps_name;
	
	private int sup_price;
	
	private int addinven;
	
	private int minven;
	
	// 파일처리
	
	public int getMinven() {
		return minven;
	}

	public void setMinven(int minven) {
		this.minven = minven;
	}

	private int file_code;
	
	private String file_name;
	
	private String rel_path;
	
	private int size;
	
	private String abs_path;


		public String getPrd_code() {
		return prd_code;
	}

	public void setPrd_code(String prd_code) {
		this.prd_code = prd_code;
	}

	public String getPrd_name() {
		return prd_name;
	}

	public void setPrd_name(String prd_name) {
		this.prd_name = prd_name;
	}

	public String getPb_code() {
		return pb_code;
	}

	public void setPb_code(String pb_code) {
		this.pb_code = pb_code;
	}

	public String getPs_code() {
		return ps_code;
	}

	public void setPs_code(String ps_code) {
		this.ps_code = ps_code;
	}

	public int getSup_price() {
		return sup_price;
	}

	public void setSup_price(int sup_price) {
		this.sup_price = sup_price;
	}

	public int getAddinven() {
		return addinven;
	}

	public void setAddinven(int addinven) {
		this.addinven = addinven;
	}

	public int getFile_code() {
		return file_code;
	}

	public void setFile_code(int file_code) {
		this.file_code = file_code;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getRel_path() {
		return rel_path;
	}

	public void setRel_path(String rel_path) {
		this.rel_path = rel_path;
	}

	public int getSize() {
		return size;
	}

	public void setSize(int size) {
		this.size = size;
	}

	public String getAbs_path() {
		return abs_path;
	}

	public void setAbs_path(String abs_path) {
		this.abs_path = abs_path;
	}
	
	public String getPb_name() {
		return pb_name;
	}

	public void setPb_name(String pb_name) {
		this.pb_name = pb_name;
	}

	public String getPs_name() {
		return ps_name;
	}

	public void setPs_name(String ps_name) {
		this.ps_name = ps_name;
	}

	@Override
	public String toString() {
		return "productModel [prd_code=" + prd_code + ", prd_name=" + prd_name + ", pb_code=" + pb_code + ", pb_name="
				+ pb_name + ", ps_code=" + ps_code + ", ps_name=" + ps_name + ", sup_price=" + sup_price + ", addinven="
				+ addinven + ", file_code=" + file_code + ", file_name=" + file_name + ", rel_path=" + rel_path
				+ ", size=" + size + ", abs_path=" + abs_path + "]";
	}

	
}	