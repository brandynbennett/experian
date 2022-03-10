Mox.defmock(ApiClientFun.Services.UserMock, for: ApiClientFun.Services.UserBehaviour)
Mox.stub_with(ApiClientFun.Services.UserMock, ApiClientFun.Services.UserStub)

ExUnit.start()
