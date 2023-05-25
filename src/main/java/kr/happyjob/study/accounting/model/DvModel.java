package kr.happyjob.study.accounting.model;

public class DvModel {

	private String dv_code /*내역번호*/;
    private String loginID /*아이디*/;
    private String bacc_name /*계정대분류명*/;
    private String dacc_name /*상세분류명*/;
    private String biz_name /*거래처명*/;
    private String biz_code /*거래처명*/;
    private String dv_date /*신청일자*/;
    private String dv_udate /*사용일자*/;
    private int dv_fee /*지출금액*/;
    private String dv_sign  /*승인여부*/;
    private String name /*승인자*/;
    private String dv_memo /**/;
    private String dv_reres /*반려사유*/;
    private String file_name /**/;
    private int file_size /**/;
    private String file_nadd /**/;
    private String file_madd /**/;
    private String bacc_code;
    private String dacc_code;
    private int file_code;
    private String dv_signUser;
    private String signName;
    
    
     
    
    
	public String getDv_code() {
		return dv_code;
	}
	public void setDv_code(String dv_code) {
		this.dv_code = dv_code;
	}
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public String getBacc_name() {
		return bacc_name;
	}
	public void setBacc_name(String bacc_name) {
		this.bacc_name = bacc_name;
	}
	public String getDacc_name() {
		return dacc_name;
	}
	public void setDacc_name(String dacc_name) {
		this.dacc_name = dacc_name;
	}
	public String getBiz_name() {
		return biz_name;
	}
	public void setBiz_name(String biz_name) {
		this.biz_name = biz_name;
	}
	public String getBiz_code() {
		return biz_code;
	}
	public void setBiz_code(String biz_code) {
		this.biz_code = biz_code;
	}
	public String getDv_date() {
		return dv_date;
	}
	public void setDv_date(String dv_date) {
		this.dv_date = dv_date;
	}
	public String getDv_udate() {
		return dv_udate;
	}
	public void setDv_udate(String dv_udate) {
		this.dv_udate = dv_udate;
	}
	public int getDv_fee() {
		return dv_fee;
	}
	public void setDv_fee(int dv_fee) {
		this.dv_fee = dv_fee;
	}
	public String getDv_sign() {
		return dv_sign;
	}
	public void setDv_sign(String dv_sign) {
		this.dv_sign = dv_sign;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDv_memo() {
		return dv_memo;
	}
	public void setDv_memo(String dv_memo) {
		this.dv_memo = dv_memo;
	}
	public String getDv_reres() {
		return dv_reres;
	}
	public void setDv_reres(String dv_reres) {
		this.dv_reres = dv_reres;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public int getFile_size() {
		return file_size;
	}
	public void setFile_size(int file_size) {
		this.file_size = file_size;
	}
	public String getFile_nadd() {
		return file_nadd;
	}
	public void setFile_nadd(String file_nadd) {
		this.file_nadd = file_nadd;
	}
	public String getFile_madd() {
		return file_madd;
	}
	public void setFile_madd(String file_madd) {
		this.file_madd = file_madd;
	}
	public String getBacc_code() {
		return bacc_code;
	}
	public void setBacc_code(String bacc_code) {
		this.bacc_code = bacc_code;
	}
	public String getDacc_code() {
		return dacc_code;
	}
	public void setDacc_code(String dacc_code) {
		this.dacc_code = dacc_code;
	}
	public int getFile_code() {
		return file_code;
	}
	public void setFile_code(int file_code) {
		this.file_code = file_code;
	}
	public String getDv_signUser() {
		return dv_signUser;
	}
	public void setDv_signUser(String dv_signUser) {
		this.dv_signUser = dv_signUser;
	}
	public String getSignName() {
		return signName;
	}
	public void setSignName(String signName) {
		this.signName = signName;
	}
    
}