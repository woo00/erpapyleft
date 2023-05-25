package kr.happyjob.study.sales.model;

public class SalesModel {
	
	  private String est_odate; 		/*주문일자*/
      private String biz_code;  		/*거래처코드*/
      private String biz_name;  		/*거래처명*/
      private String prd_name;  		/*항목명*/
      private int est_ocnt;  			/*수량*/
      private int sup_price;			/*단가*/
      private int sppl;  				/*공급가액*/
      private int tax;					/*부가세*/
      private int pay_price; 			/*합계*/
      private String order_date; 		/*주문날짜*/
      private int sum_sales; 			/*매출*/
      private int sum_ar;				/*미수금*/
      private int sum_cost; 			/*매출원가*/
      private int margin;				/*매출총이익*/
      private double salesProfit_rate;	/*영업이익률*/
      private double cumsum_sales;
      private int orderCnt;
      private int net_profit;			/*당기순이익*/
      private float sales_growth;		/*전년대비 매출 성장률*/
      private float profit_growth;		/*전년대비 순이익 성장률*/
      
      
	public String getEst_odate() {
		return est_odate;
	}
	public void setEst_odate(String est_odate) {
		this.est_odate = est_odate;
	}
	public String getBiz_code() {
		return biz_code;
	}
	public void setBiz_code(String biz_code) {
		this.biz_code = biz_code;
	}
	public String getBiz_name() {
		return biz_name;
	}
	public void setBiz_name(String biz_name) {
		this.biz_name = biz_name;
	}
	public String getPrd_name() {
		return prd_name;
	}
	public void setPrd_name(String prd_name) {
		this.prd_name = prd_name;
	}
	public int getEst_ocnt() {
		return est_ocnt;
	}
	public void setEst_ocnt(int est_ocnt) {
		this.est_ocnt = est_ocnt;
	}
	public int getSup_price() {
		return sup_price;
	}
	public void setSup_price(int sup_price) {
		this.sup_price = sup_price;
	}
	public int getSppl() {
		return sppl;
	}
	public void setSppl(int sppl) {
		this.sppl = sppl;
	}
	public int getTax() {
		return tax;
	}
	public void setTax(int tax) {
		this.tax = tax;
	}
	public int getPay_price() {
		return pay_price;
	}
	public void setPay_price(int pay_price) {
		this.pay_price = pay_price;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public int getSum_sales() {
		return sum_sales;
	}
	public void setSum_sales(int sum_sales) {
		this.sum_sales = sum_sales;
	}
	public int getSum_ar() {
		return sum_ar;
	}
	public void setSum_ar(int sum_ar) {
		this.sum_ar = sum_ar;
	}
	public int getSum_cost() {
		return sum_cost;
	}
	public void setSum_cost(int sum_cost) {
		this.sum_cost = sum_cost;
	}
	public int getMargin() {
		return margin;
	}
	public void setMargin(int margin) {
		this.margin = margin;
	}
	public double getSalesProfit_rate() {
		return salesProfit_rate;
	}
	public void setSalesProfit_rate(double salesProfit_rate) {
		this.salesProfit_rate = salesProfit_rate;
	}
	public double getCumsum_sales() {
		return cumsum_sales;
	}
	public void setCumsum_sales(double cumsum_sales) {
		this.cumsum_sales = cumsum_sales;
	}
	public int getOrderCnt() {
		return orderCnt;
	}
	public void setOrderCnt(int orderCnt) {
		this.orderCnt = orderCnt;
	}
	public int getNet_profit() {
		return net_profit;
	}
	public void setNet_profit(int net_profit) {
		this.net_profit = net_profit;
	}
	public float getSales_growth() {
		return sales_growth;
	}
	public void setSales_growth(float sales_growth) {
		this.sales_growth = sales_growth;
	}
	public float getProfit_growth() {
		return profit_growth;
	}
	public void setProfit_growth(float profit_growth) {
		this.profit_growth = profit_growth;
	}

}
