enum State{
  LOADING, ERROR, SUCCESS
}

class Resource<T> {

  State state;
  T data;
  dynamic error;

  Resource.success(T _data){
    state = State.SUCCESS;
    data = _data;
    error = null;
  }

  Resource.error(dynamic _error){
    state = State.ERROR;
    data = null;
    error = _error;
  }

  Resource.loading(){
    state = State.LOADING;
    data = null;
    error = null;
  }

  isLoading() => state == State.LOADING;
  isSuccess() => state == State.SUCCESS;
  isError() => state == State.ERROR;

}
