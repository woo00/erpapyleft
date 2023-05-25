
;(function($, window, document, undefined) {
	
	var 
		pluginName = 'prdComcombo',
		
		defaults = {
			prolall: 'prolall', 	// 대분류 코드
			promall: 'promall', 	// 소분류 코드
			prodall: 'prodall', 	// 제품 코드
			prd_name: 'prd_name', 	// 제품 이름
			url: '/system/prdComcombo.do',
		}
	
	function Plugin(element, elements) {
		this.elements = $.extend({}, defaults, elements);
		
		this.pb; // 대분류 selected index
		this.ps; // 소분류 selected index

        this.init();
	}
	
	Plugin.prototype = {
        
        init: function() {
        	
        	console.log(this.elements);

        	this.url = this.elements.url;
            this.$prolall = $('#' + this.elements.prolall); // 대분류 코드
            this.$promall = $('#' + this.elements.promall); // 소분류 코드
            this.$prodall = $('#' + this.elements.prodall); // 물품 코드
            this.prd_name = this.elements.prd_name;

            this.drawComcombo();
        },

        findComcombo: function(code) {
        	
        	var that = this;
        	that.prd_code = code;
        	
			function callback(data) {
				that.pb = data.prd.pb_code;
				that.ps = data.prd.ps_code;
				that.prdName = data.prd.prd_name;
				that.prd_code = that.prd_code || data.prd.prd_code
				that.$prolall.val(that.pb).prop('selected', true);
				that.$prolall.trigger('change');
			}
			
			var params = {
				prd_code: that.prd_code
			};
        	
        	callAjax(that.url, "post", "json", false, params, callback);
        },

        /**
         * @param {string} prd_code 제품 코드 
         */
		drawComcombo: function(url) {
			
			var that = this;
			
			// 대분류에 이벤트가 발생했을 경우
			that.$prolall.change(function() {
			   	productCombo("m", that.elements.promall, "sel", that.pb, "",  "", false);
				   console.log(that.$promall);
			   	that.$promall.val(that.ps).prop('selected', true);
			   	
			   	// 제품쪽 내용 삭제
			   	if(that.$promall[0].nodeName === 'SELECT') {
			   		that.$prodall.children('option:not(:first)').remove();	   		
			   	}
			   	else {
                    that.$promall.val('');
			   	}
			   	
			   	// 소분류 event trigger
			   	that.$promall.trigger('change');
			   	that.ps = '';
			});
			
			// 소분류에 이벤트가 발생했을 경우
			that.$promall.change(function() {
				if(that.$prodall[0].nodeName === 'SELECT') {
					productCombo("p", that.elements.prodall, "sel", that.pb, that.ps,  "", false);
					that.$prodall.val(that.prd_code).prop('selected', true);
					that.$prodall.prop('name', 'prd_code');
					that.prd_code = '';
				}
				else {
					that.$prodall.val(that.prdName);
					that.$prodall.prop('name', that.prd_name);
				}
				that.prdName = '';
			});
			
			productCombo("l", that.elements.prolall, "sel", "", "",  "", false); 
			that.$prolall.val(that.pb).prop('selected', true);
			that.$prolall.trigger('change');
		},

		empty: function() {
			var that = this;
			that.$prolall.val('').prop('selected', true);
			that.$prolall.trigger('change');
		}
		
	};
	
    /**
     * @param elements
     *  promall: 대분류 코드 select id
     *  prolall: 소분류 코드 select id
     *  prodall: 코드 select or input id
     *  prd_name: 이름 input id
     * @param options
     *  method: Plugin 메서드에서 호출할 메서드
     *  value: 코드
     */
	$.fn[pluginName] = function(options, value) {
		if(options === undefined || typeof options === 'object') {
			$.data(this[0], 'plugin_' + pluginName, new Plugin(this, options));
		}
		else if(typeof options === 'string') {
			var instance = $.data(this[0], 'plugin_' + pluginName);
            instance[options](value);
		}
	}
	
})(jQuery, this, document);