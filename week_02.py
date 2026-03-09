class Person:

    name: str
    age: int
    univ: str
    major: str
    student_id: str

    def __init__(self, **kwargs) -> None:
        if not kwargs or len(kwargs) != 5:
            raise ValueError(f"Person 클래스는 5개의 인자를 받아야 합니다.")

        for key, value in kwargs.items():
            setattr(self, key, value)

data_minsu = {
    "name": "김민수",
    "age": 27,
    "univ": "조선대학교",
    "major": "인공지능공학과",
    "student_id": "20244792"
}

minsu = Person(**data_minsu)

for k, v in minsu.__dict__.items():
    print(f"{k}: {v}")