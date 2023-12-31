package com.gdj68.mapblog.notice;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.gdj68.mapblog.util.Pager;

@Repository
public class NoticeDAO {
	@Autowired
	private SqlSession sqlSession;
	private final String NAMESPACE="com.gdj68.mapblog.notice.noticeDAO.";
	public Long getTotal(Pager pager) throws Exception{
		return sqlSession.selectOne(NAMESPACE+"getTotal");
	}
	public List<NoticeDTO> getList(Pager pager) throws Exception{
		return sqlSession.selectList(NAMESPACE+"getList", pager);
	}
	
	public int setAdd(NoticeDTO noticeDTO) throws Exception{
		return sqlSession.insert(NAMESPACE+"setAdd", noticeDTO);
	}
	public int setFileAdd(NoticeFileDTO noticeFileDTO) throws Exception{
		return sqlSession.insert(NAMESPACE+"setFileAdd", noticeFileDTO);
	}
	public NoticeDTO getDetail(NoticeDTO noticeDTO) throws Exception {
		return sqlSession.selectOne(NAMESPACE+"getDetail", noticeDTO);
	}
	public int setDelete(NoticeDTO noticeDTO) throws Exception{
		return sqlSession.delete(NAMESPACE+"setDelete", noticeDTO);
	}
	public int setUpdate(NoticeDTO noticeDTO) throws Exception{
		return sqlSession.update(NAMESPACE+"setUpdate", noticeDTO);
	}
	
}
