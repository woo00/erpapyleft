package kr.happyjob.study.sales.model;

import java.util.Date;

public class ARMModel {
	
	// 견적서/수주서
	private String loginID;		//사용자번호
	private int est_code;		//견적번호
	private int biz_code;		//거래처번호
	private String est_edate;		//견적작성일
	private String est_odate;		//수주작성일
	private String est_yn;		//입금여부
	//거래처정보
	private String biz_name;	//거래처명
	private String biz_iname;	//담당자
	private String biz_phone;	//휴대전화
	private String biz_bank;	//은행
	private String biz_ac;		//계좌번호
	
	private int psd;			//미수금
	private String sign_user;	//처리자
	private String detail_name;	//수금상태
	
	public String getLoginID() {
		return loginID;
	}
	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}
	public int getEst_code() {
		return est_code;
	}
	public void setEst_code(int est_code) {
		this.est_code = est_code;
	}
	public int getBiz_code() {
		return biz_code;
	}
	public void setBiz_code(int biz_code) {
		this.biz_code = biz_code;
	}
	public String getEst_edate() {
		return est_edate;
	}
	public void setEst_edate(String est_edate) {
		this.est_edate = est_edate;
	}
	public String getEst_odate() {
		return est_odate;
	}
	public void setEst_odate(String est_odate) {
		this.est_odate = est_odate;
	}
	public String getEst_yn() {
		return est_yn;
	}
	public void setEst_yn(String est_yn) {
		this.est_yn = est_yn;
	}
	public String getBiz_name() {
		return biz_name;
	}
	public void setBiz_name(String biz_name) {
		this.biz_name = biz_name;
	}
	public String getBiz_iname() {
		return biz_iname;
	}
	public void setBiz_iname(String biz_iname) {
		this.biz_iname = biz_iname;
	}
	public String getBiz_phone() {
		return biz_phone;
	}
	public void setBiz_phone(String biz_phone) {
		this.biz_phone = biz_phone;
	}
	public String getBiz_bank() {
		return biz_bank;
	}
	public void setBiz_bank(String biz_bank) {
		this.biz_bank = biz_bank;
	}
	public String getBiz_ac() {
		return biz_ac;
	}
	public void setBiz_ac(String biz_ac) {
		this.biz_ac = biz_ac;
	}
	public int getPsd() {
		return psd;
	}
	public void setPsd(int psd) {
		this.psd = psd;
	}
	public String getSign_user() {
		return sign_user;
	}
	public void setSign_user(String sign_user) {
		this.sign_user = sign_user;
	}
	public String getDetail_name() {
		return detail_name;
	}
	public void setDetail_name(String detail_name) {
		this.detail_name = detail_name;
	}
	
	
	

	
}
	