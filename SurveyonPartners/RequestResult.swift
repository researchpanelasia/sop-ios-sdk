//
//  RequestResult.swift
//  SurveyonPartners
//
//  Created by Choi Jiseon on 2017/03/22.
//  Copyright © 2017年 d8aspring. All rights reserved.
//

public enum RequestResult<T: RequestProtocol> {
  /**
   Represents succesful result of a `GraphRequestProtocol`.
   Encapsulates response from the server.
   */
  case success(response: Response)
  /**
   Represents errored result of a `GraphRequestProtocol`.
   Encapsulates error that was encountered.
   */
  case failed(Error)
}
