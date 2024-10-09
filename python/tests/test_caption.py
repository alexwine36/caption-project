from .utils import base_path



test_cases = [("4275"), ("5778"), ("5790"), ("5865"), ("5912"), ("7357"), ("7366")]


def test_results():
    from caption_project.caption import ImageCaption

    for case in test_cases:
        image_path = base_path / f"IMG_{case}.HEIC"

        image = ImageCaption(image_path)
        res = image.caption
        print("RES", res)
        assert res is not None
