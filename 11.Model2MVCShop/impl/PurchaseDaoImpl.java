package com.model2.mvc.service.purchase.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseDao;

@Repository
public class PurchaseDaoImpl implements PurchaseDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public PurchaseDaoImpl() {
		System.out.println(":: "+getClass()+" default 생성자 호출...");
	}
	
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("::"+getClass()+".setPurcahseDaoUImpl 호출");
	}

//	@Override
//	public Map<String, Object> getPurchaseList(Search search, String buyerId) throws Exception {
//		
//		Map<String, Object>map = new HashMap<String, Object>();
//		
//		map.put("search", search);
//		map.put("buyerId", buyerId);
//		
//		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
//		
//		for (int i = 0; i < list.size(); i++) {
//			list.get(i).setBuyer(sqlSession.selectOne("UserMapper.getUser", list.get(i).getBuyer().getUserId()) );
//			list.get(i).setPurchaseProd(sqlSession.selectOne("ProductMapper.getProduct", list.get(i).getPurchaseProd().getProdNo()));
//			
//		}
//		
//		map.put("list", list);
//		map.put("totalRow", sqlSession.selectOne("PurchaseMapper.getPurchaseTotalRow", buyerId) );
//
//		return map;
//	}
	
	@Override
	public List<Purchase> getPurchaseList(Search search, String buyerId)throws Exception{
		
		Map<String, Object>map = new HashMap<String, Object>();
		
		map.put("search", search);
		map.put("buyerId", buyerId);
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getPurchaseList", map);
		//System.out.println(":"+list);
		
		for (int i = 0; i < list.size(); i++) {
			//System.out.println("::"+list.get(i).getPurchaseProd().getProTranCode());
			
			//System.out.println("_"+( list.get(i).getTranCode() ).trim()+"_");
//			String tranCode = ( list.get(i).getTranCode() ).trim();
			
			list.get(i).setBuyer(sqlSession.selectOne("UserMapper.getUser", list.get(i).getBuyer().getUserId()) );
			list.get(i).setPurchaseProd(sqlSession.selectOne("ProductMapper.getProduct", list.get(i).getPurchaseProd().getProdNo()));
			list.get(i).getPurchaseProd().setProTranCode(( list.get(i).getTranCode() ).trim());
		
			//System.out.println("최종:"+list.get(i));
		}
		
		return list;  
	}
	
	@Override
	public int getPurchaseTotalRow(String buyerId)throws Exception{
		
		int totalRow = sqlSession.selectOne("PurchaseMapper.getPurchaseTotalRow", buyerId);
		System.out.println("total:"+totalRow);
		
		return totalRow;
	}

	

	@Override
	public void insertPurchase(Purchase purchase) throws Exception {
		sqlSession.insert("PurchaseMapper.addPurchase", purchase);

	}

	@Override
	public void updateTranCode(int tranNo, String tranCode) throws Exception {
		Purchase purchase = new Purchase();
		purchase.setTranNo(tranNo);
		purchase.setTranCode(tranCode);
		sqlSession.update("PurchaseMapper.updateTranCode", purchase);
	}

	@Override
	public Purchase findPurchase(int tranNo) throws Exception {
		return sqlSession.selectOne("PurchaseMapper.getPurchase", tranNo);
	}

	@Override
	public void updatePurchase(Purchase purchase) throws Exception {
		sqlSession.update("PurchaseMapper.updatePurchase", purchase);

	}

	@Override
	public Map<String, Object> getSaleList(Search search) throws Exception {
		
		List<Purchase> list = sqlSession.selectList("PurchaseMapper.getSaleList", search);
		List<String> state = new ArrayList<String>();
		List<String> delivery = new ArrayList<String>();
		
		for (int i = 0; i < list.size(); i++) {
			String tranCode = (list.get(i).getTranCode() ).trim();
			//System.out.println("_"+tranCode+"_");
			
			list.get(i).setBuyer(sqlSession.selectOne("UserMapper.getUser", list.get(i).getBuyer().getUserId()) );
			list.get(i).setPurchaseProd(sqlSession.selectOne("ProductMapper.getProduct", list.get(i).getPurchaseProd().getProdNo()) );
			list.get(i).setTranCode(tranCode);
			//System.out.println(list.get(i));
			
			/////////////////
			String prodDelivery = "";
			String prodState ="";
			if(tranCode.equals("1")) {
				prodState = "구매완료";
				prodDelivery = ("배송하기");
			}else if(tranCode.equals("2")) {
				prodState = "배송중";
				prodDelivery = "";
			}else if(tranCode.equals("3")) {
				prodState = "배송완료";
				prodDelivery = "";
			}
			
			state.add(prodState);
			delivery.add(prodDelivery);
			
			//System.out.println(":"+state);
			//System.out.println("::"+delivery);
		}	
		
		Map<String, Object> map = new HashMap<String, Object>();
			
		map.put("saleList", list);
		map.put("totalCount",  sqlSession.selectOne("PurchaseMapper.getSaleTotalRow"));
		map.put("state", state);
		map.put("delivery", delivery);
		return map;
		
	}

}
