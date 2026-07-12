import functools
from typing import Any, Callable

def require_hf_hub(func: Callable[..., Any]) -> Callable[..., Any]:
    @functools.wraps(func)
    def wrapper(*args: Any, **kwargs: Any) -> Any:
        try:
            import huggingface_hub
        except ImportError:
            raise ImportError(
                "The 'huggingface_hub' library is required for this feature. "
                "Please install it using: pip install huggingface_hub"
            )
        return func(*args, **kwargs)
    return wrapper